Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56995 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874Ab2HOPJA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 11:09:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 24/31] arm64: Add support for /proc/sys/debug/exception-trace
Date: Wed, 15 Aug 2012 15:08:57 +0000
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-25-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-25-git-send-email-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Message-ID: <201208151508.57474.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20120815150857.T9ahdcGcMW0wgP6UCSitNNzseYFK6aOtKse-weh-eyg@z>

On Tuesday 14 August 2012, Catalin Marinas wrote:
> 
> This patch allows setting of the show_unhandled_signals variable via
> /proc/sys/debug/exception-trace. The default value is currently 1
> showing unhandled user faults (undefined instructions, data aborts) and
> invalid signal stack frames.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
