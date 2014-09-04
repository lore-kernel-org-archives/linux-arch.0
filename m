Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:47254 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754983AbaIDTmu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Sep 2014 15:42:50 -0400
Message-ID: <5408C0AB.6050801@hurleysoftware.com>
Date: Thu, 04 Sep 2014 15:42:35 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
Subject: Re: bit fields && data tearing
References: <20140712181328.GA8738@redhat.com>	<54079B70.4050200@hurleysoftware.com>	<1409785893.30640.118.camel@pasglop>	<21512.10628.412205.873477@gargle.gargle.HOWL>	<20140904090952.GW17454@tucnak.redhat.com>	<540859EC.5000407@hurleysoftware.com> <20140904175044.4697aee4@alan.etchedpixels.co.uk>
In-Reply-To: <20140904175044.4697aee4@alan.etchedpixels.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Jakub Jelinek <jakub@redhat.com>, Mikael Pettersson <mikpelinux@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Oleg Nesterov <oleg@redhat.com>, Miroslav Franc <mfranc@redhat.com>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org
Message-ID: <20140904194235.qUCmRDfwgV8sdwEhtu8vM-8fMzpMamrIT5fMGIU95uc@z>

On 09/04/2014 12:50 PM, One Thousand Gnomes wrote:
>> Besides updating the documentation, it may make sense to do something
>> arch-specific. Just bumping out storage on arches that don't need it
>> seems wasteful, as does generating bus locks on arches that don't need it.
>> Unfortunately, the code churn looks unavoidable.
> 
> The arch specific is pretty much set_bit and friends. Bus locks on a
> locally owned cache line should not be very expensive on anything vaguely
> modern, while uniprocessor boxes usually only have to generate set_bit
> as a single instruction so it is interrupt safe.

Or we could give up on the Alpha.

It's not just the non-atomic bytes; we could do away with the
read_barrier_depends() which hardly any code gets correctly anyway.

Regards,
Peter Hurley

