From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] modpost: Ignore ARC specific non-alloc sections
Date: Wed, 2 Jan 2013 10:46:38 +0530
Message-ID: <50E3C2B6.9010208@synopsys.com>
References: <1352720953-24321-21-git-send-email-vgupta@synopsys.com> <1356605240-4555-1-git-send-email-vgupta@synopsys.com> <1356605240-4555-2-git-send-email-vgupta@synopsys.com> <20121227204816.GA2068@merkur.ravnborg.org> <8738yk76k6.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:39855 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3ABFS2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2013 00:18:28 -0500
In-Reply-To: <8738yk76k6.fsf@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, Michal Marek <mmarek@suse.cz>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wednesday 02 January 2013 06:19 AM, Rusty Russell wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
>
>> On Thu, Dec 27, 2012 at 04:17:20PM +0530, Vineet Gupta wrote:
>>> ARC relocatable object files contain one/more .gnu.linkonce.arcextmap.*
>>> sections (collated by kernel/vmlinux.lds into .arcextmap in final link).
>>> This section is used by debuggers to display the extension instructions
>>> and need-not be loaded by target (hence !SHF_ALLOC)
>>>
>>> The final kernel binary only needs .arcextmap entry in modpost's ignore
>>> list (section_white_list[]). However when building modules, modpost scans
>>> each object file individually, hence tripping on non-aggregated
>>> .gnu.linkonce.arcextmap.* entries as well.
>> The list exist for this particular purpose.
>> So acked.
> Applied, thanks!
>
> Cheers,
> Rusty.

Thanks Rusty.
I'll drop this patch from my series.

-Vineet
