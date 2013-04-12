From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] Kbuild: Avoid DTB rebuilds if source files are untouched
Date: Fri, 12 Apr 2013 15:52:44 -0600
Message-ID: <5168822C.6040303@wwwdotorg.org>
References: <1364973141-16354-1-git-send-email-vgupta@synopsys.com> <515BD6B8.1020607@synopsys.com> <515C5652.8070705@wwwdotorg.org> <515D0FFB.4030803@synopsys.com> <515DBA0E.6000604@wwwdotorg.org> <51642158.3070205@synopsys.com> <5167BA67.5080403@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <5167BA67.5080403@synopsys.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.cz>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-arch.vger.kernel.org

On 04/12/2013 01:40 AM, Vineet Gupta wrote:
> On 04/09/2013 07:40 PM, Vineet Gupta wrote:
>> On 04/04/2013 11:06 PM, Stephen Warren wrote:
>>
>>> +.SECONDARY: $(obj)/%.dtb.S
>>> +
>>>  $(obj)/%.dtb.S: $(obj)/%.dtb
>>>         $(call cmd,dt_S_dtb)
>>>
>>> and no longer see make rm'ing the .dtb.S file. So, the .SECONDARY is
>>> behaving as expected, and should fix your problem.
>> Interestingly, if I make the file name explicit, .SECONDARY works for me too.
>>
>> .SECONDARY: $(obj)/angel4.dtb.S
>>
>> http://stackoverflow.com/questions/5426934/why-this-makefile-removes-my-goal
>>
>> Is this a make bug or is it related to when the rule is parsed by make !
>>
>> -Vineet
> 
> Ping ? Anyone know how to resolve this

After installing the ARC toolchain (which was a bit painful to track
down and install...) I reproduced your exact problem. I believe the
patch below fixes it:

diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile
index 5776835..2f2cf23 100644
--- a/arch/arc/boot/dts/Makefile
+++ b/arch/arc/boot/dts/Makefile
@@ -8,6 +8,8 @@ endif
 obj-y   += $(builtindtb-y).dtb.o
 targets += $(builtindtb-y).dtb

+.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
+
 dtbs:  $(addprefix  $(obj)/, $(builtindtb-y).dtb)

 clean-files := *.dtb

