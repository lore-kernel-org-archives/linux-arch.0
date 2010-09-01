From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 18/22] Fix M68K irqflags
Date: Wed, 1 Sep 2010 16:38:39 +1000
Message-ID: <4C7DF4EF.30109@snapgear.com>
References: <AANLkTikJ5pio3WYmZFAyWpD32hssZoDxX7XSTXN_qV09@mail.gmail.com> <20100827015905.27277.39167.stgit@warthog.procyon.org.uk> <20100827020038.27277.27239.stgit@warthog.procyon.org.uk> <4C7B59E1.6010904@snapgear.com> <26799.1283201411@redhat.com> <11403.1283270415@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:13152 "HELO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752209Ab0IAGiw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Sep 2010 02:38:52 -0400
In-Reply-To: <11403.1283270415@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/09/10 02:00, David Howells wrote:
> Geert Uytterhoeven<geert@linux-m68k.org>  wrote:
>
>> Indeed, m68k doesn't use generic hardirqs yet, m68knommu does.
>
> That's orthogonal to this patch series, however.  I'm dealing with IRQ flags
> management, not hardirq support.
>
> Out of interest, will the m68knommu arch be integrated into the m68k arch at
> some point?  It's certainly possible to have an arch that is bimodal in this
> aspect (FRV has CONFIG_MMU as a config option).

At some point it will happen. Steven King sent a script to
largely automate for a first pass about a year ago.

Regards
Greg
