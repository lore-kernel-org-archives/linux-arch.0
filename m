From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3.10 29/31] vm: make stack guard page errors return VM_FAULT_SIGSEGV rather than SIGBUS
Date: Sun, 26 Apr 2015 15:46:49 +0200
Message-ID: <20150426134210.615526786@linuxfoundation.org>
References: <20150426134209.255099785@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150426134209.255099785@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

3.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 9c145c56d0c8a0b62e48c8d71e055ad0fb2012ba upstream.

The stack guard page error case has long incorrectly caused a SIGBUS
rather than a SIGSEGV, but nobody actually noticed until commit
fee7e49d4514 ("mm: propagate error from stack expansion even for guard
page") because that error case was never actually triggered in any
normal situations.

Now that we actually report the error, people noticed the wrong signal
that resulted.  So far, only the test suite of libsigsegv seems to have
actually cared, but there are real applications that use libsigsegv, so
let's not wait for any of those to break.

Reported-and-tested-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Jan Engelhardt <jengelh@inai.de>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # "s390 still compiles and boots"
Cc: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3232,7 +3232,7 @@ static int do_anonymous_page(struct mm_s
 
 	/* Check if we need to add a guard page to the stack */
 	if (check_stack_guard_page(vma, address) < 0)
-		return VM_FAULT_SIGBUS;
+		return VM_FAULT_SIGSEGV;
 
 	/* Use the zero-page for reads */
 	if (!(flags & FAULT_FLAG_WRITE)) {
