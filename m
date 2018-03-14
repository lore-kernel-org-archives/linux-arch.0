From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 08/16] procfs: remove CONFIG_HARDWALL dependency
Date: Wed, 14 Mar 2018 20:41:51 +0300
Message-ID: <20180314174150.GA2068@avx2>
References: <20180314143755.1508262-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180314143755.1508262-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Michal Hocko <mhocko@suse.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 14, 2018 at 03:37:37PM +0100, Arnd Bergmann wrote:
> Hardwall is a tile specific feature, and with the removal of the
> tile architecture, this has become dead code, so let's remove it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

ACK

Although it should go via tile tree for "atomicity".
