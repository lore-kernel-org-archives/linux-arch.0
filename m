Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from na3sys010aog107.obsmtp.com ([74.125.245.82]:47408 "HELO
	na3sys010aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750831Ab1ESEXB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 May 2011 00:23:01 -0400
MIME-Version: 1.0
In-Reply-To: <x86-32-writeq-is-broken@mdm.bga.com>
References: <20110504115324.GE17855@lsi.com> <1305616571.6008.23.camel@mulgrave.site>
 <B2FD678A64EAAD45B089B123FDFC3ED70157F7BCE5@inbmail01.lsi.com>
 <20110518041551.GL15227@parisc-linux.org> <1305692584.2580.3.camel@mulgrave.site>
 <1305702010.2781.33.camel@pasglop> <mpt2sas-writeq-powerpc64@mdm.bga.com>
 <4565AEA676113A449269C2F3A549520F80B66280@cosmail03.lsi.com> <x86-32-writeq-is-broken@mdm.bga.com>
From: Roland Dreier <roland@kernel.org>
Date: Wed, 18 May 2011 21:16:49 -0700
Message-ID: <BANLkTimDktq8SxOU3HZkPpj=J9pdkzVX-w@mail.gmail.com>
Subject: Re: [PATCH 1/3] mpt2sas: remove the use of writeq, since writeq is
 not atomic
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Milton Miller <miltonm@bga.com>
Cc: Hitoshi Mitake <h.mitake@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@redhat.com>, "Desai, Kashyap" <Kashyap.Desai@lsi.com>, "Prakash, Sathya" <Sathya.Prakash@lsi.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Matthew Wilcox <matthew@wil.cx>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux scsi dev <linux-scsi@vger.kernel.org>, "paulus@samba.org" <paulus@samba.org>, linux powerpc dev <linuxppc-dev@lists.ozlabs.org>, linux pci <linux-pci@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20110519041649.YXh73hWilI7KmKaV05RV0UiU_g10M-q1ZzmZ1U33R6k@z>

On Wed, May 18, 2011 at 11:31 AM, Milton Miller <miltonm@bga.com> wrote:
> So the real question should be why is x86-32 supplying a broken writeq
> instead of letting drivers work out what to do it when needed?

Sounds a lot like what I was asking a couple of years ago :)
http://lkml.org/lkml/2009/4/19/164

But Ingo insisted that non-atomic writeq would be fine:
http://lkml.org/lkml/2009/4/19/167

 - R.
