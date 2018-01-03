Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751526AbeACMb3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jan 2018 07:31:29 -0500
From: Florian Weimer <fweimer@redhat.com>
Subject: [PATCH] mm, x86: pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change
 signal semantics
Message-ID: <360ef254-48bc-aee6-70f9-858f773b8693@redhat.com>
Date: Wed, 3 Jan 2018 13:31:25 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------63FE4E7AB35B75B5A148D63E"
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, linux-x86_64@vger.kernel.org, Linux API <linux-api@vger.kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, Ram Pai <linuxram@us.ibm.com>
Message-ID: <20180103123125.zTUzEmJAvZWV6FpFK5xHMQqAYgQIBIIBYx4TXW4lvgo@z>

This is a multi-part message in MIME format.
--------------63FE4E7AB35B75B5A148D63E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

This patch is based on the previous discussion (pkeys: Support setting 
access rights for signal handlers):

   https://marc.info/?t=151285426000001

It aligns the signal semantics of the x86 implementation with the 
upcoming POWER implementation, and defines a new flag, so that 
applications can detect which semantics the kernel uses.

A change in this area is needed to make memory protection keys usable 
for protecting the GOT in the dynamic linker.

(Feel free to replace the trigraphs in the commit message before 
committing, or to remove the program altogether.)

Thanks,
Florian

--------------63FE4E7AB35B75B5A148D63E
Content-Type: text/x-patch;
 name="pkeys-signalinherit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pkeys-signalinherit.patch"


--------------63FE4E7AB35B75B5A148D63E--
