
const pullWorkflows = async () => {
    let r = [];
        
    let nextPageToken = undefined;

    for (let i = 0; i <= 4; i++) {
        let url =
            "https://bff.circleci.com/private/web-ui-service/project/github/laurentsenta/testground-stability/pipeline?";

        if (nextPageToken) {
            url = url + "next_page_token=" + nextPageToken;
        }

        const q = await fetch(url, {
            headers: {
            accept: "*/*",
            "accept-language": "en-GB,en-US;q=0.9,en;q=0.8",
            "content-type": "application/json",
            "sec-fetch-dest": "empty",
            "sec-fetch-mode": "cors",
            "sec-fetch-site": "same-site",
            "sec-gpc": "1",
            },
            referrer: "https://app.circleci.com/",
            referrerPolicy: "strict-origin-when-cross-origin",
            body: null,
            method: "GET",
            mode: "cors",
            credentials: "include",
        });

        const j = await q.json();

        console.log('j=', j, nextPageToken);
        nextPageToken = j.next_page_token;

        r = [...r, ...j.items]
    }

    return r;
};

const pullWorkflowResults = async (items) => {
    const result = []

    // Slow on purpose.
    for (const item of items) {
        const line = {
            id: item.id,
            created_at: item.created_at,
            branch: item.vcs.branch,
            subject: item.vcs.commit.subject,
            globalStatus: item.status,
        }

        const workflows = item.workflows[0];
        const workflowId = workflows.id;

        const q = await  fetch(
            `https://circleci.com/api/v2/workflow/${workflowId}/job`,
            {
              referrerPolicy: "strict-origin-when-cross-origin",
              body: null,
              method: "GET",
              mode: "cors",
              credentials: "include",
            }
          );

          const j = await q.json();
          console.log(j)

          const items = j.items

          items.forEach(item => {
              const jobLine = {
                  jobId: item.id,
                  name: item.name,
                  status: item.status
              }

              result.push({...line, ...jobLine})
          })
    }

    return result;
}
