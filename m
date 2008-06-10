From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [patch 02/41] cpu alloc: The allocator
Date: Tue, 10 Jun 2008 20:05:18 +0200
Message-ID: <484EC25E.4070209@cosmosbay.com>
References: <20080530035620.587204923@sgi.com> <20080530040011.084909898@sgi.com> <483F8AF7.9000309@cosmosbay.com> <Pine.LNX.4.64.0805292219220.12107@schroedinger.engr.sgi.com> <4846AD84.2090800@sgi.com> <Pine.LNX.4.64.0806101032550.17131@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp28.orange.fr ([80.12.242.99]:44498 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbYFJSFf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jun 2008 14:05:35 -0400
In-Reply-To: <Pine.LNX.4.64.0806101032550.17131@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Mike Travis <travis@sgi.com>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>

Christoph Lameter a =E9crit :
> On Wed, 4 Jun 2008, Mike Travis wrote:
>=20
>> I'm a bit confused.  Why is DEFINE_PER_CPU_SHARED_ALIGNED() conditio=
ned on
>> ifdef MODULE?
>>
>>         #ifdef MODULE
>>         #define SHARED_ALIGNED_SECTION ".data.percpu"
>>         #else
>>         #define SHARED_ALIGNED_SECTION ".data.percpu.shared_aligned"
>>         #endif
>>
>>         #define DEFINE_PER_CPU_SHARED_ALIGNED(type, name)           =
            \
>>                 __attribute__((__section__(SHARED_ALIGNED_SECTION)))=
            \
>>                 PER_CPU_ATTRIBUTES __typeof__(type) per_cpu__##name =
            \
>>                 ____cacheline_aligned_in_smp
>=20
> Looks wrong to me. There can be shared objects even without modules.
>=20
>=20

Well, MODULE is not CONFIG_MODULES :)

If compiling an object that is going to be statically linked to kernel,=
=20
MODULE is not defined, so we have shared objects.

When compiling a module, we cannot *yet* use .data.percpu.shared_aligne=
d=20
section, since module loader wont handle this section.

Alternative is to change modules linking for all arches to merge=20
=2Edata.percpu{*} subsections correctly, or tell module loader to take=20
into account all .data.percpu sections.

AFAIK no module uses DEFINE_PER_CPU_SHARED_ALIGNED() yet...
