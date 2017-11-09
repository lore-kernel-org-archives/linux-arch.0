Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752622AbdKIN6L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Nov 2017 08:58:11 -0500
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com [209.85.128.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E373121957
        for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2017 13:58:10 +0000 (UTC)
Received: by mail-wr0-f169.google.com with SMTP id j23so5669765wra.9
        for <linux-arch@vger.kernel.org>; Thu, 09 Nov 2017 05:58:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAEbi=3e-hRbej7EZ68-J1YPNfdxu7O_BAZ1rvZvAhhYzAT09-g@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <1a8efba0727437d510d10755f3fcea806833651d.1510118606.git.green.hu@gmail.com>
 <CAL_JsqJAtTSGg=yGvANGdTCWa4tDAicvOvWYr4pK5M1rjPFtfg@mail.gmail.com> <CAEbi=3e-hRbej7EZ68-J1YPNfdxu7O_BAZ1rvZvAhhYzAT09-g@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 9 Nov 2017 07:57:48 -0600
Message-ID: <CABGGisw5gi92aM0_tZ0htOzwZTFJpcSNZUJth5TzRXPxzssRxA@mail.gmail.com>
Subject: Re: [PATCH 30/31] dt-bindings: nds32 CPU Bindings
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Greentime <greentime@andestech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Message-ID: <20171109135748.6gpyY_t4Zz_xViA7GcIHfePy_yEDukPdF87q5dg-QWA@z>

On Thu, Nov 9, 2017 at 3:39 AM, Greentime Hu <green.hu@gmail.com> wrote:
> 2017-11-08 21:18 GMT+08:00 Rob Herring <robh+dt@kernel.org>:
>> Please Cc the DT list on bindings.
>
> Sorry. I am not sure what you mean.
> Do you mean add devicetree@vger.kernel.org to cc list?

Yes. Use get_maintainers.pl as a guide.

>> On Tue, Nov 7, 2017 at 11:55 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>> From: Greentime Hu <greentime@andestech.com>
>>

>>> +                       device_type = "cpu";
>>> +                       compatible = "andestech,n13", "andestech,n15";
>>
>> n13 is a superset of n15?
>
> No, they are independent ones.

Then having both is not valid. The strings should be in order of best
match to worst match where worst match is typically either older
implementations of IP blocks or generic'ish strings such as "ns16550"
for a UART.

Rob
