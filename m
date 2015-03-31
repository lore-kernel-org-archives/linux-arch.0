Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:51598 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbbCaFKV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 Mar 2015 01:10:21 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Question on ARC's thread_info
Date: Tue, 31 Mar 2015 05:10:17 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307566597AEF@IN01WEMBXB.internal.synopsys.com>
References: <551736C4.6080203@nod.at>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20150331051017.R7DhfXfr6HctXBk5eOjsHMuPPHq1dh7lDLWKJ-kMFyc@z>

On Sunday 29 March 2015 04:48 AM, Richard Weinberger wrote:
> Vineet,
>
> I'm working on a patch series which touches sturct thread_info.
> ARC's thread_info has the following comment:
>  * - if the contents of this structure are changed, the assembly constants
>  *   must also be changed
>
> Is this still true? Unless I'm reading the code wrong that case should be
> handled automatically by the asm-offsets mechanism.
> So no manual fixup of magic constants should be needed.


Yep, I think that is the case too - perhaps the comment is dated when we still had
magic constants in code :-)
If not I need to fix it anyways so feel free to change it.

-Vineet

