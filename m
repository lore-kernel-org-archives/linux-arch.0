From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] modpost: Ignore ARC specific non-alloc sections
Date: Wed, 02 Jan 2013 11:19:13 +1030
Message-ID: <8738yk76k6.fsf@rustcorp.com.au>
References: <1352720953-24321-21-git-send-email-vgupta@synopsys.com> <1356605240-4555-1-git-send-email-vgupta@synopsys.com> <1356605240-4555-2-git-send-email-vgupta@synopsys.com> <20121227204816.GA2068@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121227204816.GA2068@merkur.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Michal Marek <mmarek@suse.cz>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> On Thu, Dec 27, 2012 at 04:17:20PM +0530, Vineet Gupta wrote:
>> ARC relocatable object files contain one/more .gnu.linkonce.arcextmap.*
>> sections (collated by kernel/vmlinux.lds into .arcextmap in final link).
>> This section is used by debuggers to display the extension instructions
>> and need-not be loaded by target (hence !SHF_ALLOC)
>> 
>> The final kernel binary only needs .arcextmap entry in modpost's ignore
>> list (section_white_list[]). However when building modules, modpost scans
>> each object file individually, hence tripping on non-aggregated
>> .gnu.linkonce.arcextmap.* entries as well.
>
> The list exist for this particular purpose.
> So acked.

Applied, thanks!

Cheers,
Rusty.
