From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 00/28] nios2 Linux kernel port
Date: Fri, 18 Apr 2014 13:48:44 -0700
Message-ID: <53518FAC.8020504@zytor.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397824031-4892-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: lftan.linux@gmail.com, cltang@codesourcery.com, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On 04/18/2014 05:26 AM, Ley Foon Tan wrote:
> This patchset adds the Linux kernel port for Nios II processor from Altera.
> The nios2 Linux port follows the guidance for new architecture ports using
> generic headers (including unistd.h).

Did the generic headers ever get updated to match Linus' guidance that
any new architecture ports should use a 64-bit time_t?

	-hpa
