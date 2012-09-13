From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 26/31] arm64: Miscellaneous library functions
Date: Thu, 13 Sep 2012 10:48:22 +0000
Message-ID: <201209131048.22385.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <201209071952.14309.arnd@arndb.de> <20120912211259.GA8252@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120912211259.GA8252@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
