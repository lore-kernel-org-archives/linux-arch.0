Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33003 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbXGTRqG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jul 2007 13:46:06 -0400
Message-ID: <46A0F4AC.50809@zytor.com>
Date: Fri, 20 Jul 2007 10:45:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: build fix for x86_64...
References: <617E1C2C70743745A92448908E030B2A01FA46A9@scsmsx411.amr.corp.intel.com>	<46A0EAC8.9020203@zytor.com> <jezm1rq8gz.fsf@sykes.suse.de>
In-Reply-To: <jezm1rq8gz.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Andi Kleen <ak@novell.com>, Arthur Jones <arthur.jones@qlogic.com>, Vasily Tarasov <vtaras@openvz.org>, linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andreas Schwab wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> No, that would be bad.  If compat_u64 is used to carry 32-bit ABIs
>> forward into 64-bit space without needing compatibility hacks, then this
>> would actually introduce ABI incompatibilities depending on CONFIG_COMPAT!
> 
> But without CONFIG_COMPAT there is no 32-bit ABI, thus no need for
> compat_u64 in the first place.
> 

You're missing the point.

Someone introduces an interface, which uses a structure:

struct foo {
	u32 bar;
	u64 baz;
	u32 quux;
};

Now, we want to port that to 64 bits.  We can either introduce a
thunking function to mangle the argument, or we can redefine the structure:

struct foo {
	u32 bar;
	compat_u64 baz;
	u32 quux;
};

... which is still ABI compatible on 32 bits, but doesn't require thunking.

Obviously, this is not a panacea; if the original "struct foo" has also
been introduced on 64 bits before the bug is caught, then you're screwed.

	-hpa

	
