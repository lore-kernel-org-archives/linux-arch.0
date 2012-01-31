From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH -v3 0/14] PCI: allocate pci bus num range for unassigned
 bridge busn
Date: Tue, 31 Jan 2012 09:49:34 -0800
Message-ID: <CAErSpo54k=pL1P1z7OetC1qJbsH9LH0GY4QFy-=PPKR0vF14SA@mail.gmail.com>
References: <1327995772-11388-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53299 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753230Ab2AaRt4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 Jan 2012 12:49:56 -0500
Received: by lagu2 with SMTP id u2so159760lag.19
        for <linux-arch@vger.kernel.org>; Tue, 31 Jan 2012 09:49:54 -0800 (PST)
In-Reply-To: <1327995772-11388-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Jan 30, 2012 at 11:42 PM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> could be found at:
> =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/=
linux-yinghai.git for-pci-busn-alloc
>
> -v2: according to Jesse, split to more small patches.
> -v3: address some request from Bjorn. like make use %pR for busn_res =
debug print
> =A0 =A0 =A0 =A0out, and move the comment change with code change.

I don't see v3 in that git tree; maybe it needs to be pushed?
