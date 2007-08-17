Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:30111 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034AbXHQJyK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Aug 2007 05:54:10 -0400
Received: by wa-out-1112.google.com with SMTP id j4so186431wah
        for <linux-arch@vger.kernel.org>; Fri, 17 Aug 2007 02:54:10 -0700 (PDT)
Message-ID: <88dfed9d0708170254r6c2e172foc3061d99ce930e31@mail.gmail.com>
Date: Fri, 17 Aug 2007 17:54:10 +0800
From: hufey <hufeyy@gmail.com>
Subject: strange probe order issue after platform_add_devices()
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi list,

I am facing a very strange issue about device probe order.
I have a piece of code to support network interface card for an embedded box.

It likes following:

...
static struct platform_device *custom_devices[] __initdata = {
           &a_device,
           &b_device,
           &c_device,
};

static int __init device_init()
{
            return platform_add_devices(custom_devices,
ARRAY_SIZE(custom_devices);
}

subsys_initcall(device_init);

/* end */

This code works good with kernel 2.6.11. After platform_add_devices()
is executed, a_device's probe function will be called first then
b_device's probe function be called.
I merged it to 2.6.17, but strange thing is b_device's probe be called
first always now.
Since b_device probe depends on a_device, so it always fails now.

Does anyone know how to fix it? Or give me the hint about how kernel
decide which device be called to probe in order by what mechanism?

Thanks in advance and best regards,
hufeyy
