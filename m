From: Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
Date: Tue, 17 Apr 2012 11:49:35 -0700
Message-ID: <CA+8MBbJGZRKemR+p95B0nZt95TVb3+BxeJPRnP1dJ=EvGxWBXA@mail.gmail.com>
References: <1334483574-3997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334483574-3997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Apr 15, 2012 at 2:52 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Rather than requiring architectures that use gpiolib but don't have any
> need to define anything custom to copy an asm/gpio.h provide a Kconfig
> symbol which architectures must select in order to include gpio.h and
> for other architectures just provide the trivial implementation directly.

ia64 parts:

Acked-by: Tony Luck <tony.luck@intel.com>
