Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alln-iport-3.cisco.com ([173.37.142.90]:8750 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbeJaJVe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Oct 2018 05:21:34 -0400
Subject: Re: [PATCH v5] kernel/signal: Signal-based pre-coredump notification
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com>
 <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
 <20181029111804.GA24820@redhat.com>
 <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
 <20181030164628.GD7643@redhat.com>
From: Enke Chen <enkechen@cisco.com>
Message-ID: <b50b14cd-e1a9-ff7d-12e0-c3613e125be9@cisco.com>
Date: Tue, 30 Oct 2018 17:25:51 -0700
MIME-Version: 1.0
In-Reply-To: <20181030164628.GD7643@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roman Gushchin <guro@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Cyrill Gorcunov <gorcunov@openvz.org>, Yang Shi <yang.shi@linux.alibaba.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>, Enke Chen <enkechen@cisco.com>
Message-ID: <20181031002551.zbVG5J0MQT3TeycwPK0wLmUw602d-MNafj_Pwb3NypE@z>

Hi, Oleg:

On 10/30/18 9:46 AM, Oleg Nesterov wrote:
> On 10/29, Enke Chen wrote:
>>
>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> Hmm. I didn't say this ;)
> 
> But OK, feel free to keep this tag.

Thanks.

> 
> I do not like this feauture. But I see no technical problems in this version
> and I never pretented I understand the user-space needs, so I won't argue.

As I explained earlier, the primary application is in the area of network
high-availability / non-stop-forwarding where early fault notification and
early action can help maintain BFD sessions and thus avoid unnecessary
disruption to forwarding while the control-plane is recovering.

-- Enke
