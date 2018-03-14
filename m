Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:46148 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeCNRl4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Mar 2018 13:41:56 -0400
Date: Wed, 14 Mar 2018 20:41:51 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 08/16] procfs: remove CONFIG_HARDWALL dependency
Message-ID: <20180314174150.GA2068@avx2>
References: <20180314143755.1508262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314143755.1508262-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Michal Hocko <mhocko@suse.com>
Message-ID: <20180314174151.tL4OZprtLl706YnkEbs6M9NwB-2GXnD9vyvaun4HUk0@z>

On Wed, Mar 14, 2018 at 03:37:37PM +0100, Arnd Bergmann wrote:
> Hardwall is a tile specific feature, and with the removal of the
> tile architecture, this has become dead code, so let's remove it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

ACK

Although it should go via tile tree for "atomicity".
