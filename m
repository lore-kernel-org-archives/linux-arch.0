From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ARM: delete struct sys_timer
Date: Thu, 08 Nov 2012 14:04:28 -0700
Message-ID: <509C1E5C.3060306@wwwdotorg.org>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org> <1352408516-21988-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352408516-21988-2-git-send-email-swarren@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 11/08/2012 02:01 PM, Stephen Warren wrote:
> Now that the only field in struct sys_timer is .init, delete the struct,
> and replace the machine descriptor .timer field with the initialization
> function itself.

Oops. This one patch is a duplicate of 11/11 in the series I just sent.
Sorry.
