From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
 the Kernel Summit
Date: Wed, 17 Jun 2009 10:14:17 -0700
Message-ID: <4A392469.8040309@zytor.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <4A373EE6.6070201@compulab.co.il> <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com> <20090616121909.GA1547@linux-mips.org> <4A38705A.3060007@zytor.com> <20090617150414.GA18525@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:55617 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbZFQROq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2009 13:14:46 -0400
In-Reply-To: <20090617150414.GA18525@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Mike Rapoport <mike@compulab.co.il>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org

Ralf Baechle wrote:
>>
>> However, on most systems, even embedded, bringing up memory falls on
>> firmware (sometimes in the form of a boot loader) so Linux rarely sees it.
> 
> There are embedded systems were the firmware does not provide a usuable
> memory map or where that is plain broken.  Or Linux with some extra init
> code serves as the firmware.  Often there is a single serial EEPROM for
> the entire system.  If there is an atrocity that can save a penny it will
> be commited at least in the embedded world.
> 

"Rarely" is certainly not "never".  Quite on the contrary.  Also, I
think you can remove "that can save a penny" from your last sentence...

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
