From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 00/10] Hi,
Date: Mon, 17 Feb 2020 15:27:42 +0100
Message-ID: <0f8140c1-da6f-ef04-0809-252d6de6a5d7@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
 <CAL_JsqJeXJ6zWvEUi=gyOV0eCcXsvNmkK9EstC9hg9AKfMXnKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:56010
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727898AbgBQO2K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Feb 2020 09:28:10 -0500
In-Reply-To: <CAL_JsqJeXJ6zWvEUi=gyOV0eCcXsvNmkK9EstC9hg9AKfMXnKw@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Borislav Petkov <bp@suse.de>, Cornelia Huck <cohuck@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Greg Ungerer <gerg@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mike Rapoport <rppt@linux.ibm.com>, Mubin Sayyed <mubinusm@xilinx.com>, Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Palmer

Hi Rob,

On 14. 02. 20 0:47, Rob Herring wrote:
> On Wed, Feb 12, 2020 at 2:58 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>>
>> I am sending this series as before SMP support.
>> Most of these patches are clean ups and should be easy to review them. I
>> expect there will be more discussions about SMP support.
> 
> While not really related to adding SMP, any chance you or someone
> could look at moving microblaze PCI support to drivers/pci/? I suspect
> much of the code should drop out as we have common helpers for much of
> it now. That would leave only powerpc and mips for DT+PCI platforms.

can you please suggest changes which could be done?
I have CC Bharat and he could look at it.

Thanks,
Michal
