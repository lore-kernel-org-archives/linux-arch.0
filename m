From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Question on ARC's thread_info
Date: Tue, 31 Mar 2015 05:10:17 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307566597AEF@IN01WEMBXB.internal.synopsys.com>
References: <551736C4.6080203@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
