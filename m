From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/31] arm64: Process management
Date: Wed, 15 Aug 2012 13:53:01 +0000
Message-ID: <201208151353.01367.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-8-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58284 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab2HONxF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 09:53:05 -0400
In-Reply-To: <1344966752-16102-8-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:

> +#define THREAD_SIZE_ORDER	1
> +#define THREAD_SIZE		8192
> +#define THREAD_START_SP		(THREAD_SIZE - 16)

THREAD_SIZE_ORDER looks wrong for 64kb-page kernels. It also doesn't seem to
be used, so better remove it.

	Arnd
