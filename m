From: Andi Kleen <ak@linux.intel.com>
Subject: Re: + add-a-kernel_address-that-works-for-data-too.patch added to
 -mm tree
Date: Sat, 09 Jan 2010 07:31:57 +0100
Message-ID: <4B4822DD.2090406@linux.intel.com>
References: <201001082354.o08Ns4iM021858@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52137 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782Ab0AIGcD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 9 Jan 2010 01:32:03 -0500
In-Reply-To: <201001082354.o08Ns4iM021858@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, andi@firstfloor.org, ebiederm@xmission.com, linux-arch@vger.kernel.org, rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au, sam@ravnborg.org

akpm@linux-foundation.org wrote:

> ------------------------------------------------------
> Subject: add a kernel_address() that works for data too
> From: Andi Kleen <andi@firstfloor.org>
> 
> Add a variant of kernel_text_address() that includes kernel data.
> 
> Assumes kernel is _text ... _end - init section. True everywhere?

As Russel pointed out that is broken on ARM XIP kernels currently.
I'm looking at a fix for that.

-Andi
