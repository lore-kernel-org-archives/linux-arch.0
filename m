From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 27/31] arm64: Loadable modules
Date: Wed, 15 Aug 2012 16:16:56 +0000
Message-ID: <201208151616.56932.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <201208151523.21447.arnd@arndb.de> <20120815153538.GA14264@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58144 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab2HOQRD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 12:17:03 -0400
In-Reply-To: <20120815153538.GA14264@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>

On Wednesday 15 August 2012, Catalin Marinas wrote:
> Primarily branch relocation, we have a limitation to 128MB branch range.
> The alternative would be to always compile the modules with a large
> memory model but we may lose some performance and could make the
> relocation handling even harder. What we do now is pretty much similar
> to static linking but at module load time.

Ok, makes sense.

	Arnd
