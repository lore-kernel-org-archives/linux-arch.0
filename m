From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] Kbuild: Avoid DTB rebuilds if source files are untouched
Date: Wed, 17 Apr 2013 10:13:22 +0100
Message-ID: <516E67B2.20509@imgtec.com>
References: <1364973141-16354-1-git-send-email-vgupta@synopsys.com> <515BD6B8.1020607@synopsys.com> <515C5652.8070705@wwwdotorg.org> <515D0FFB.4030803@synopsys.com> <515DBA0E.6000604@wwwdotorg.org> <51642158.3070205@synopsys.com> <5167BA67.5080403@synopsys.com> <5168822C.6040303@wwwdotorg.org> <516D7405.3060202@imgtec.com> <516E2169.4020007@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <516E2169.4020007@synopsys.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.cz>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-arch.vger.kernel.org

On 17/04/13 05:13, Vineet Gupta wrote:
> Hi James,
> 
> On 04/16/2013 09:23 PM, James Hogan wrote:
>> On 12/04/13 22:52, Stephen Warren wrote:
>>> +.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
>> Note, this may not work if you're using CONFIG_ARC_BUILTIN_DTB_NAME,
>> since it'll have quotes around it, so you may instead need:
>> .SECONDARY: $(obj)/$(patsubst "%",%,$(builtindtb-y)).dtb.S
>>
>> (at least that's what's required for the metag equivalent)
>>
>>> +
>>>  dtbs:  $(addprefix  $(obj)/, $(builtindtb-y).dtb)
>> You might find the same thing here too.
> 
> Actually in my Makefile, the quotes are stripped off in the very beginning to
> avoid duplicating it in every place.
> 
> ifneq ($(CONFIG_ARC_BUILTIN_DTB_NAME),"")
>     builtindtb-y    := $(patsubst "%",%,$(CONFIG_ARC_BUILTIN_DTB_NAME))
> endif

Ah yes, I didn't notice that difference. I'll do the same thing for
metag (it only had 1 reference to it before).

Thanks
James

