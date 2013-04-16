From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] Kbuild: Avoid DTB rebuilds if source files are untouched
Date: Tue, 16 Apr 2013 17:02:08 +0100
Message-ID: <516D7600.4080002@imgtec.com>
References: <1364973141-16354-1-git-send-email-vgupta@synopsys.com> <515BD6B8.1020607@synopsys.com> <515C5652.8070705@wwwdotorg.org> <515D0FFB.4030803@synopsys.com> <515DBA0E.6000604@wwwdotorg.org> <51642158.3070205@synopsys.com> <5167BA67.5080403@synopsys.com> <5168822C.6040303@wwwdotorg.org> <516D7405.3060202@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <516D7405.3060202@imgtec.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.cz>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-arch.vger.kernel.org

On 16/04/13 16:53, James Hogan wrote:
> On 12/04/13 22:52, Stephen Warren wrote:
>> +.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
> 
> Note, this may not work if you're using CONFIG_ARC_BUILTIN_DTB_NAME,
> since it'll have quotes around it, so you may instead need:
> .SECONDARY: $(obj)/$(patsubst "%",%,$(builtindtb-y)).dtb.S
> 
> (at least that's what's required for the metag equivalent)
> 
>> +
>>  dtbs:  $(addprefix  $(obj)/, $(builtindtb-y).dtb)
> 
> You might find the same thing here too.

Also, I think you probably now want *.dtb.S added to clean-files,
otherwise they won't get removed by make clean.

Cheers
James

