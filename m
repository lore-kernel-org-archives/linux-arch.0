Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:65382 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab2IMKs2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Sep 2012 06:48:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 26/31] arm64: Miscellaneous library functions
Date: Thu, 13 Sep 2012 10:48:22 +0000
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <201209071952.14309.arnd@arndb.de> <20120912211259.GA8252@arm.com>
In-Reply-To: <20120912211259.GA8252@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201209131048.22385.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20120913104822.0UT3-4idD1uEz0eoncLW7wbkLEOmDhcX2fdmDFk4sW0@z>

On Wednesday 12 September 2012, Catalin Marinas wrote:
> From 64ec78a2fce931e0148db90747c69688f248a531 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Wed, 12 Sep 2012 22:00:53 +0100
> Subject: [PATCH 1/2] Implement generic ffs/fls using __builtin_* functions
> 
> This patch implements ffs, __ffs, fls, __fls using __builtin_* gcc
> functions. These header files can be used by other architectures that
> rely on the gcc builtins.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Very good.

Acked-by: Arnd Bergmann <arnd@arndb.de>
