From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Thu, 4 Jun 2009 14:15:21 -0600
Message-ID: <fa686aa40906041315w54b6c9f0n650b09d4d2b8f898@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	<fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
	<20090602211057.GA10800@flint.arm.linux.org.uk> <4A2596B4.3020309@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <4A2596B4.3020309@billgatliff.com>
Sender: linux-embedded-owner@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 2, 2009 at 3:16 PM, Bill Gatliff <bgat@billgatliff.com> wro=
te:
> Russell King wrote:
>>
>> The big problem we have is that the only commonality between differe=
nt
>> SoCs is that the CPU executes ARM instructions. =A0Everything else i=
s
>> entirely up to the SoC designer - eg location of memory, spacing of
>> memory banks, type of interrupt controller, etc is all highly SoC
>> specific. =A0Nothing outside of the ARM CPU itself is standardized.
>
> And that diversity is precisely because of the diversity in ARM-based
> embedded platforms.
>
> Such diversity means that kernel/driver development is a constant act=
ivity,
> which suggests that we shouldn't bother the effort to come up with a
> comprehensive solution because none will exist. =A0Rather, we should =
maintain
> and improve the ability to rapidly prototype and adapt. =A0Things lik=
e
> furthering the deployment of platform_device, clocksource/clockdevice=
, and
> so on.

No, not comprehensive; just common.  It makes sense to spend the
effort on the patterns and devices which are common.  It may not cover
everything, but it doesn't have to to be valuable.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
