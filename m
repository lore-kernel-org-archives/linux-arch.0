Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:52458 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCVR1v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2018 13:27:51 -0400
Date: Thu, 22 Mar 2018 18:27:48 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v14 02/10] iomap: Add big endian sparse annotations to
 mmio_{read|write}XXbe()
Message-ID: <20180322172747.4rjped3gojfuhuh2@ltop.local>
References: <20180322171703.4300-1-logang@deltatee.com>
 <20180322171703.4300-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322171703.4300-3-logang@deltatee.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Message-ID: <20180322172748.RbmGXm_S208qfvhN_ewz6F1SIuCiKeDUVcGHg0kx1vE@z>

On Thu, Mar 22, 2018 at 11:16:55AM -0600, Logan Gunthorpe wrote:
> Sparse produces a few warnings of the form:
> 
> lib/iomap.c:84:9: warning: cast to restricted __be16
> 
> (The kbuild robot has recently started running such checks)

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com> 
