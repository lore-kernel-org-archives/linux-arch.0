From: Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] kexec: override GFP flag for the control page allocation
Date: Tue, 21 Apr 2015 14:06:31 +0200
Message-ID: <1429617992-31686-1-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eric Biederman <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Greetings,

I got a bug report that kexec does not work on s390 if the system has
lots of memory. It is the kexec load step that dies with out-of-memory. 

The reason why this happens is the value of KEXEC_CONTROL_MEMORY_LIMIT
for s390. To start the new kernel the code in the kexec control page
needs to switch to the ESA mode (31-bit), therefore the memory limit
is 2GB for s390. The allocation of the control page is done with
GFP_KERNEL in kimage_alloc_normal_control_pages. If the allocated page
is a target page in the kexec destination range or if its address is
larger than the memory limit, it is put on the list of extra pages
and another page is allocated until one is found that fits the
requirements.

With a large memory size not only does this loop take a long time to
complete (think 10 terabyte of memory), but eventually the OOM killer
steps in and terminates the program that called kexec load.

The fix for s390 is to use a different GFP flag, GFP_DMA instead of
GFP_KERNEL. To do this a new #define for kexec is introduced that
can be overruled by the architecture.

Martin Schwidefsky (1):
  kexec: allocate the kexec control page with KEXEC_CONTROL_MEMORY_GFP

 arch/s390/include/asm/kexec.h | 3 +++
 include/linux/kexec.h         | 4 ++++
 kernel/kexec.c                | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
1.9.1
