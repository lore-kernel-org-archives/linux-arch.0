From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/6] exec: split prepare_arg_pages
Date: Thu, 18 Jun 2020 16:46:25 +0200
Message-ID: <20200618144627.114057-5-hch@lst.de>
References: <20200618144627.114057-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20200618144627.114057-1-hch@lst.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Move counting the arguments and enviroment variables out of
prepare_arg_pages and rename the rest of the function to check_arg_limit.
This prepares for a version of do_execvat that takes kernel pointers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a5d91f8b1341d5..34781db6bf6889 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -435,20 +435,10 @@ static int count_strings(const char __user *const __user *argv)
 	return i;
 }
 
-static int prepare_arg_pages(struct linux_binprm *bprm,
-		const char __user *const __user *argv,
-		const char __user *const __user *envp)
+static int check_arg_limit(struct linux_binprm *bprm)
 {
 	unsigned long limit, ptr_size;
 
-	bprm->argc = count_strings(argv);
-	if (bprm->argc < 0)
-		return bprm->argc;
-
-	bprm->envc = count_strings(envp);
-	if (bprm->envc < 0)
-		return bprm->envc;
