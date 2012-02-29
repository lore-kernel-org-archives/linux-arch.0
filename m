From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 02/39] x86, PCI: have own version for pcibios_bus_to_resource
Date: Wed, 29 Feb 2012 15:33:36 -0800
Message-ID: <CAE9FiQW=NXnaEY+fmUS_cyJy_BE-1+pWy8kfAoPA_s=vwDq4Mw@mail.gmail.com>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
	<1330556858-11768-3-git-send-email-yinghai@kernel.org>
	<CAErSpo62VuJw+3caNUhmg5moh3h4cn5z4kCsqTWZW-XqSzpk4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40416 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300Ab2B2Xdh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Feb 2012 18:33:37 -0500
In-Reply-To: <CAErSpo62VuJw+3caNUhmg5moh3h4cn5z4kCsqTWZW-XqSzpk4Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Feb 29, 2012 at 3:20 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Feb 29, 2012 at 4:07 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> x86 does not need to offset the address. So we can skip that costing offset
>> searching.
>
> I tried to start a discussion about this patch (and others), but I
> don't think you responded:
> http://marc.info/?l=linux-pci&m=133036414506921&w=2

this patch does reduce some not needed ops.

and it does not affects your effects, and it just make x86 not get punished.

let's let Jesse and x86 maintainers to decide if this patch is needed.

Thanks

Yinghai
