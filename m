From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC v2 2/7] tables.h: add linker table support
Date: Tue, 23 Feb 2016 16:06:55 -0800
Message-ID: <56CCF41F.8080507@zytor.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-3-git-send-email-mcgrof@kernel.org>
 <56C77A53.6060708@zytor.com> <20160219214856.GX25240@wotan.suse.de>
 <CAB=NE6W8H=Sc+1gCBfua8A=qW09CrJxTpCm4Ag_qDrj_Lr6LKw@mail.gmail.com>
 <56CCE9B6.4080000@zytor.com>
 <CAB=NE6WtZtyy3xhG170id3pVGfVpgWdYhODxEi+gYRNor-GSzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:52450 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbcBXAJx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Feb 2016 19:09:53 -0500
In-Reply-To: <CAB=NE6WtZtyy3xhG170id3pVGfVpgWdYhODxEi+gYRNor-GSzw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Brown <mcb30@ipxe.org>, Juergen Gross <jgross@suse.com>, Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, David Miller <davem@davemloft.net>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, andriy.shevchenko@l

On 02/23/2016 03:36 PM, Luis R. Rodriguez wrote:
> 
>> 4. the only useful operator on a range is "is address X inside this
>>    range"; this operator is likely *not* useful for a table, since
>>    if you have to ever invoke it you are probably doing something very
>>    wrong.
> 
> kprobe uses it :P
> 

Could you explain how?

	-hpa
