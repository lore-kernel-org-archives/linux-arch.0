From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 0/7] test_user_copy improvements
Date: Wed, 5 Aug 2015 16:48:48 +0100
Message-ID: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:52788 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbbHEPtZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2015 11:49:25 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>

These patches extend the test_user_copy test module to handle lots more
cases of user accessors which architectures can override separately, and
in particular those which are important for checking the MIPS Enhanced
Virtual Addressing (EVA) implementations, which need to handle
overlapping user and kernel address spaces, with special instructions
for accessing user address space from kernel mode.

- Checking that kernel pointers are accepted when user address limit is
  set to KERNEL_DS, as done by the kernel when it internally invokes
  system calls with kernel pointers.
- Checking of the unchecked accessors (which don't call access_ok()).
  Some of the tests are special cased for EVA at the moment which has
  stricter hardware guarantees for bad user accesses than other
  configurations.
- Checking of other sets of user accessors, including the inatomic user
  copies, copy_in_user, clear_user, the user string accessors, and the
  user checksum functions, all of which need special handling in arch
  code with EVA.

Tested on MIPS with and without EVA, and on x86_64.

James Hogan (7):
  test_user_copy: Check legit kernel accesses
  test_user_copy: Check unchecked accessors
  test_user_copy: Check __clear_user()/clear_user()
  test_user_copy: Check __copy_in_user()/copy_in_user()
  test_user_copy: Check __copy_{to,from}_user_inatomic()
  test_user_copy: Check user string accessors
  test_user_copy: Check user checksum functions

 lib/test_user_copy.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)

Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
-- 
2.3.6
