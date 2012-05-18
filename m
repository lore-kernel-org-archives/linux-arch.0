From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 05/21] resource: adjust_resource handle resource without parent
Date: Fri, 18 May 2012 10:54:36 -0700
Message-ID: <CAE9FiQUebVR_AdhQVE_Hq-RhB7h5AfH0Z20WaZh=ky5vHEt5BQ@mail.gmail.com>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
	<1336422606-4244-6-git-send-email-yinghai@kernel.org>
	<CAErSpo71rKrZ7ptJjE5Lb6YnrqXVe1eGhn3pyF2Qjp=o8JHQmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44535 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965082Ab2ERRyg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 13:54:36 -0400
In-Reply-To: <CAErSpo71rKrZ7ptJjE5Lb6YnrqXVe1eGhn3pyF2Qjp=o8JHQmg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, May 18, 2012 at 10:12 AM, Bjorn Helgaas <bhelgaas@google.com> w=
rote:
> On Mon, May 7, 2012 at 2:29 PM, Yinghai Lu <yinghai@kernel.org> wrote=
:

> Where does this case occur? =A0When do you need to adjust a resource
> that has no parent?

for unassigned pci bridge from BIOS, before scan busn_res.end is 0xff,
so you can not insert them, because the bridge could in the middle.
Have to update the busn_res.end and insert after the bridge is scanned

Yinghai
