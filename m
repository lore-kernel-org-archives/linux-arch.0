From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 06/16] h8300: CPU depend helpers
Date: Mon, 9 Mar 2015 18:55:03 +0100
Message-ID: <CAMuHMdVYC5pxzZssGo2EuytD6hbimDCQ+4COUGD==Tp_tH1zcA@mail.gmail.com>
References: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp>
	<1425890830-29399-7-git-send-email-ysato@users.sourceforge.jp>
	<1425918067.5428.10.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:39942 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbbCIRzE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 13:55:04 -0400
In-Reply-To: <1425918067.5428.10.camel@perches.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Mon, Mar 9, 2015 at 5:21 PM, Joe Perches <joe@perches.com> wrote:
>>  arch/h8300/kernel/cpu/h83069/setup.c   | 202 ++++++++++++++++++++++++++
> []
>> diff --git a/arch/h8300/kernel/cpu/h83069/setup.c b/arch/h8300/kernel/cpu/h83069/setup.c
> []
>> +static struct resource sci0_resources[] = {
>> +     DEFINE_RES_MEM(0xffffb0, 8),
>> +     DEFINE_RES_IRQ(52),
>> +     DEFINE_RES_IRQ(53),
>> +     DEFINE_RES_IRQ(54),
>> +     DEFINE_RES_IRQ(55),
>> +}
>
> Perhaps most all of these might be const?
>
>> +static struct plat_sci_port sci0_platform_data = {
> []
>> +static struct resource sci1_resources[] = {
> []
>> +static struct plat_sci_port sci1_platform_data = {
> []
>> +static struct platform_device sci0_device = {
> []
>> +static struct platform_device sci1_device = {
> []
>> +static struct h8300_timer8_config tm8_unit0_platform_data = {
> []
>> +static struct resource tm8_unit0_resources[] = {
> []
>> +static struct platform_device timer8_unit0_device = {
> []
>> +static struct h8300_timer8_config tm8_unit1_platform_data = {
> []

Unfortunately not. device.platform_data and platform_device.resource are
not const pointers.

They can only be const (and __initdata) when the platform devices are
created using platform_device_register_resndata(), as that one copies the
data.

May still be a good idea to use that instead of static platform devices, though,
especially for multi-platform kernels (because the __initdata data is reclaimed
later).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
