From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 27/31] dt-bindings: interrupt-controller: Andestech
 Internal Vector Interrupt Controller
Date: Thu, 9 Nov 2017 17:43:10 +0800
Message-ID: <CAEbi=3c0n69R+YRqTBR8ftwpNmjwOFf40RhHzW5JKsGgVz0t-w@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <a7b9f0a21bf6e0c3325a0d9a28a8503082cafd14.1510118606.git.green.hu@gmail.com>
 <CAL_JsqLGQGZq9VYW2By84rf0BHPm4=QvKNts7ETCqVT3g7LA-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:51961 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbdKIJnw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Nov 2017 04:43:52 -0500
In-Reply-To: <CAL_JsqLGQGZq9VYW2By84rf0BHPm4=QvKNts7ETCqVT3g7LA-w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Greentime <greentime@andestech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, Rick Chen <rick@andestech.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

2017-11-08 21:25 GMT+08:00 Rob Herring <robh+dt@kernel.org>:
> +DT list
>
> On Tue, Nov 7, 2017 at 11:55 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>
> Commit msg needed.

Thanks.
I will add commit msg in the next version patch.

>> Signed-off-by: Rick Chen <rick@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>> ---
>>  .../interrupt-controller/andestech,ativic32.txt    |   27 ++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
>> new file mode 100644
>> index 0000000..6bac908
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
>> @@ -0,0 +1,27 @@
>> +* Andestech Internal Vector Interrupt Controller
>> +
>> +The Internal Vector Interrupt Controller (IVIC) is a basic interrupt controller
>> +suitable for a simpler SoC platform not requiring a more sophisticated and
>> +bigger External Vector Interrupt Controller.
>> +
>> +
>> +Main node required properties:
>> +
>> +- compatible : should at least contain  "andestech,ativic32".
>> +- interrupt-parent: Empty for the interrupt controller itself
>
> Drop this.

Thanks.
I will fix it in the next version patch.

>> +- interrupt-controller : Identifies the node as an interrupt controller
>> +- #interrupt-cells: The number of cells to define the interrupts. Should be 2.
>> +       The first cell is the IRQ number
>> +       The second cell is used to specify mode:
>> +               1 = low-to-high edge triggered
>> +               2 = high-to-low edge triggered
>> +               4 = active high level-sensitive
>> +               8 = active low level-sensitive
>
> Just state 2 cells and refer to interrupt-controller/interrupts.txt.

Thanks.
I will fix it in the next version patch.

>> +               Default for internal sources should be set to 4 (active high).
>> +
>> +Examples:
>> +       intc: interrupt-controller {
>> +               compatible = "andestech,ativic32";
>> +               #interrupt-cells = <2>;
>> +               interrupt-controller;
>> +       };
>> --
>> 1.7.9.5
>>
