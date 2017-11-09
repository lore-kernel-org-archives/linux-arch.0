From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 30/31] dt-bindings: nds32 CPU Bindings
Date: Thu, 9 Nov 2017 17:39:28 +0800
Message-ID: <CAEbi=3e-hRbej7EZ68-J1YPNfdxu7O_BAZ1rvZvAhhYzAT09-g@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <1a8efba0727437d510d10755f3fcea806833651d.1510118606.git.green.hu@gmail.com>
 <CAL_JsqJAtTSGg=yGvANGdTCWa4tDAicvOvWYr4pK5M1rjPFtfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJAtTSGg=yGvANGdTCWa4tDAicvOvWYr4pK5M1rjPFtfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Greentime <greentime@andestech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

2017-11-08 21:18 GMT+08:00 Rob Herring <robh+dt@kernel.org>:
> Please Cc the DT list on bindings.

Sorry. I am not sure what you mean.
Do you mean add devicetree@vger.kernel.org to cc list?

> On Tue, Nov 7, 2017 at 11:55 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>
> Commit message needed.

Thanks. I will add more commit messages in the next version patch.

>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Rick Chen <rick@andestech.com>
>> Signed-off-by: Zong Li <zong@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>> ---
>>  Documentation/devicetree/bindings/nds32/cpus.txt |   33 ++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
>>
>> diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
>> new file mode 100644
>> index 0000000..97394cb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nds32/cpus.txt
>> @@ -0,0 +1,33 @@
>> +* Andestech Processor Binding
>> +
>> +This binding specifies what properties must be available in the device tree
>> +representation of a Andestech Processor Core, which is the root node in the
>> +tree.
>> +
>> +Required properties:
>> +
>> +       - compatible:
>> +               Usage: required
>> +               Value type: <string>
>> +               Definition: should be one of:
>> +                       "andestech,n13"
>> +                       "andestech,n15"
>> +                       "andestech,d15"
>> +                       "andestech,n10"
>> +                       "andestech,d10"
>
> SMP supported for any of these?

We don't support SMP now.

>> +
>> +    - device_type
>> +               Usage: required
>> +               Value type: <string>
>> +               Definition: must be "cpu"
>> +
>> +* Examples
>> +
>> +/ {
>> +       cpus {
>> +               cpu@0 {
>
> Needs a reg property or drop the unit address.

Thanks.
I will fix it in the next version patch.

>> +                       device_type = "cpu";
>> +                       compatible = "andestech,n13", "andestech,n15";
>
> n13 is a superset of n15?

No, they are independent ones.
