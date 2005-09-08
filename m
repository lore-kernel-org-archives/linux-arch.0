Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <4320B69D.5010901@didntduck.org>
Date: Thu, 08 Sep 2005 18:09:33 -0400
From: Brian Gerst <bgerst@didntduck.org>
MIME-Version: 1.0
Subject: Re: [RFC] Consistently use the name asm-offsets.h
References: <B8E391BBE9FE384DAA4C5C003888BE6F0456EE9E@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0456EE9E@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Luck, Tony wrote:
> The existing ia64 specific rule to generate offsets.h
> has to "echo #define IA64_TASK_SIZE 0 > include/asm-ia64/offsets.h"
> before building asm-offsets.s to avoid compilation errors.
> 
> So long as you take care of this somehow in the generic version, go wild.
> 

The right fix is to get rid of that god-awful circular dependency on 
offset.h

--
				Brian Gerst
