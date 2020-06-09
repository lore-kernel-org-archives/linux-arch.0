From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2 5/6] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
Date: Tue, 9 Jun 2020 15:16:20 +0100
Message-ID: <20200609141620.GC25945@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
 <1084d017-54f3-475c-be1b-aabc801d9a71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:43088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbgFIOQZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Jun 2020 10:16:25 -0400
Content-Disposition: inline
In-Reply-To: <1084d017-54f3-475c-be1b-aabc801d9a71@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Amit Daniel Kachhap <amit.kachhap@arm.com>, Mark Rutland <mark.rutland@arm.com>

On Tue, Jun 09, 2020 at 01:36:42PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Dave,
> 
> I've applied this patch (manually, because 4/6 is not yet applied).
> I have a question below.
> 
> On 5/27/20 11:17 PM, Dave Martin wrote:
> > Add documentation for the PR_PAC_RESET_KEYS ioctl added in Linux
> > 5.0 for arm64.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > 
> > ---
> > 
> > Since v1:
> > 
> >  * Clarify explicitly that PR_PAC_RESET_KEYS is redundant when combined
> >    with execve().
> > 
> >  * Move error condition details into the prctl description, to avoid
> >    excessive duplication while keeping keeping related pieces of text
> >    closer together.
> > 
> >  * In lieu of having a separate man page to cross reference for detailed
> >    guidance, cross-reference the kernel documentation.
> > 
> >  * Add safety warning.  This is deliberately vague, pending ongoing
> >    discussions with libc folks.
> > ---
> >  man2/prctl.2 | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> > 
> 
> [...]
> 
> > +.IP
> > +.B Warning:
> > +Because the compiler or run-time environment
> > +may be using some or all of the keys,
> > +a successful
> 
> Things got a bit garbled here. I think the next few lines should have been 
> at the end.
> > +.IP
> > +For more information, see the kernel source file
> > +.I Documentation/arm64/pointer\-authentication.rst
> > +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
> > +(or
> > +.I Documentation/arm64/pointer\-authentication.txt
> > +before Linux 5.3).
> > +.B PR_PAC_RESET_KEYS
> > +may crash the calling process.
> > +The conditions for using it safely are complex and system-dependent.
> > +Don't use it unless you know what you are doing.
> 
> I applied the following change after your patch; is it okay?
> 
>  .IP
>  .B Warning:
>  Because the compiler or run-time environment
>  may be using some or all of the keys,
>  a successful

Looks fine, execpt that I think you need to move the

	.B PR_PAC_RESET_KEYS

line here also.

Thanks
---Dave

> +may crash the calling process.
> +The conditions for using it safely are complex and system-dependent.
> +Don't use it unless you know what you are doing.
>  .IP
>  For more information, see the kernel source file
>  .I Documentation/arm64/pointer\-authentication.rst
> @@ -1020,9 +1023,6 @@ For more information, see the kernel source file
>  .I Documentation/arm64/pointer\-authentication.txt
>  before Linux 5.3).
>  .B PR_PAC_RESET_KEYS
> -may crash the calling process.
> -The conditions for using it safely are complex and system-dependent.
> -Don't use it unless you know what you are doing.
>  .\" prctl PR_SET_PDEATHSIG
>  .TP
>  .BR PR_SET_PDEATHSIG " (since Linux 2.1.57)"
> 

[...]
