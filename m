From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/16] procfs: remove CONFIG_HARDWALL dependency
Date: Wed, 14 Mar 2018 21:18:00 +0100
Message-ID: <CAK8P3a1fJEY7iy9FghcU-WE8Q=gwZxU6b=aVoFPsbR5sHGkyUQ@mail.gmail.com>
References: <20180314143755.1508262-1-arnd@arndb.de> <20180314174150.GA2068@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314174150.GA2068@avx2>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Michal Hocko <mhocko@suse.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 14, 2018 at 6:41 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Wed, Mar 14, 2018 at 03:37:37PM +0100, Arnd Bergmann wrote:
>> Hardwall is a tile specific feature, and with the removal of the
>> tile architecture, this has become dead code, so let's remove it.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> ACK
>
> Although it should go via tile tree for "atomicity".

Both the arch/tile removal and this patch are in my asm-generic tree, as there
is no longer a tile specific git.

Thanks for your Ack!

       Arnd
