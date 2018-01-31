From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [GIT PULL] siginfo fix for 4.16-rc1
Date: Wed, 31 Jan 2018 10:19:01 -0600
Message-ID: <87607im26i.fsf_-_@xmission.com>
References: <87372oph61.fsf@xmission.com> <87a7wwnkce.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87a7wwnkce.fsf@xmission.com> (Eric W. Biederman's message of
        "Mon, 29 Jan 2018 20:36:49 -0600")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: f20239c0d2d720d7deb8a40fd05c31849ddc8293  mm/memory_failure: update powerpc for memory_failure() API change

I had a brain fart when I received Stephen email about a compile failure
in linux-next.  I thought the powerpc call to memory_failure had not
merged yet.  Instead it simply failed to compile :(

Linus can you please pull Stephen's fix so that powerpc builds correctly.

Thank you,
Eric 

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 26 Jan 2018 12:05:12 +1100
Subject: [PATCH] mm/memory_failure: update powerpc for memory_failure() API change

After merging the userns tree, today's linux-next build (powerpc
allyesconfig) failed like this:

arch/powerpc/kernel/mce.c: In function 'machine_process_ue_event':
arch/powerpc/kernel/mce.c:276:5: error: too many arguments to function 'memory_failure'
     memory_failure(pfn, SIGBUS, 0);
     ^~~~~~~~~~~~~~
In file included from include/linux/pid_namespace.h:7:0,
                 from include/linux/ptrace.h:10,
                 from arch/powerpc/kernel/mce.c:27:
include/linux/mm.h:2571:12: note: declared here
 extern int memory_failure(unsigned long pfn, int flags);
            ^~~~~~~~~~~~~~

Caused by commit

  83b57531c58f ("mm/memory_failure: Remove unused trapno from memory_failure")

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/powerpc/kernel/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 742e4658c5dc..71e8a1b8c86e 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -273,7 +273,7 @@ static void machine_process_ue_event(struct work_struct *work)
 
 				pfn = evt->u.ue_error.physical_address >>
 					PAGE_SHIFT;
-				memory_failure(pfn, SIGBUS, 0);
+				memory_failure(pfn, 0);
 			} else
 				pr_warn("Failed to identify bad address from "
 					"where the uncorrectable error (UE) "
-- 
2.14.1
