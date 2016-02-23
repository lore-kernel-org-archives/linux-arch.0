From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC v2 2/7] tables.h: add linker table support
Date: Tue, 23 Feb 2016 15:36:21 -0800
Message-ID: <CAB=NE6WtZtyy3xhG170id3pVGfVpgWdYhODxEi+gYRNor-GSzw@mail.gmail.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-3-git-send-email-mcgrof@kernel.org> <56C77A53.6060708@zytor.com>
 <20160219214856.GX25240@wotan.suse.de> <CAB=NE6W8H=Sc+1gCBfua8A=qW09CrJxTpCm4Ag_qDrj_Lr6LKw@mail.gmail.com>
 <56CCE9B6.4080000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56242 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbcBWXgq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Feb 2016 18:36:46 -0500
In-Reply-To: <56CCE9B6.4080000@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Brown <mcb30@ipxe.org>, Juergen Gross <jgross@suse.com>, Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, David Miller <davem@davemloft.net>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, andriy.shevchenko@l

On Tue, Feb 23, 2016 at 3:22 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 02/23/2016 03:08 PM, Luis R. Rodriguez wrote:
>>
>> OK yes I see the issue now. I've modified this to use const, and
>> retested the kprobe patch and it works well still. kprobe would not
>> use LINKTABLE_TEXT, instead it uses its own macro, however users of
>> LINKTABLE_TEXT would then have const declared. The implications are
>> that you *can* declare structs so long as everything is const.
>>
>
> No, such structures belong in .rodata not in .text.
>
> I have been thinking about it somewhat, and for text we really have text
> "ranges" rather than tables.  The big difference between the two are:
>
> 1. priority ordering doesn't make any sense for ranges.

I considered the possibility perhaps we want to just split out a
series of initial basic macros that enables *only* such basic
functionality and declarations, and linker tables would then build on
top of these. I think that ma help here.

> 2. ranges can be hierarchial, that is, range "bar" can be entirely
>    inside range "foo".

We'd want to enable this without having to modify the linker script
further -- I thought about how such things might be possible but not
for this case but rather, for the case where in linker tables a
developer may wish to get range addresses for a specific order level.
Although separate, the problem seems similar. At least in theory I was
convinced I had a solution to the order level problem, perhaps it may
suffice for this too:

When and if you need an intermediary set of range addresses you then
also declare another set of extern pointers, similar in nature with
the empty string and ~ ending delimiter, we just move one notch in.
SORT() will take care of ordering things for us, but the issue here is
the empty string doesn't allow hierarchies so perhaps to enable that
we may need another beginning delimiter that would enable recursive
hierarchies. If this seems to at least in theory make sense I can give
it a shot through a simple proof of concept and see if it works.

> 3. ranges aren't typed (although in C, that pretty much means they are
>    "char" or "unsigned char" as there really isn't any way to define an
>    "array of void".)

Sure. kprobe is a good example.

> 4. the only useful operator on a range is "is address X inside this
>    range"; this operator is likely *not* useful for a table, since
>    if you have to ever invoke it you are probably doing something very
>    wrong.

kprobe uses it :P

> For this to work, we need strings such that they will always sort in the
> appropriate order with the bracket symbols around subranges.  I need to
> think about this a few minutes before I actually say anything about it...

Ah seems we're in the same line of thought ?

 Luis
