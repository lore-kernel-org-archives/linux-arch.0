From: Enke Chen <enkechen@cisco.com>
Subject: Re: [PATCH v5] kernel/signal: Signal-based pre-coredump notification
Date: Wed, 21 Nov 2018 17:18:25 -0800
Message-ID: <44f0214e-93cf-ef19-f590-1a1a9e0f44b3@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com>
 <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
 <20181029111804.GA24820@redhat.com>
 <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
 <20181030164628.GD7643@redhat.com>
 <20181121163711.2c00316784d221eb1750edb0@linux-foundation.org>
 <ae3b48ef-6bb0-2bc2-eca6-651fdb2dce37@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ae3b48ef-6bb0-2bc2-eca6-651fdb2dce37@cisco.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>
List-Id: linux-arch.vger.kernel.org

Hi, Andrew:

On 11/21/18 5:09 PM, Enke Chen wrote:
> Hi, Andrew:
> 
> On 11/21/18 4:37 PM, Andrew Morton wrote:

>> Do we have other linux-specific signal extensions which could piggyback onto that?
> 
> No. There are enough existing signals that an application can choose for this
> purpose, such as SIGUSR1, SIGUSR1, and any of the RT signals.
> 
> Thanks.  -- Enke
> 

Let me clarify: I meant this feature is complete by itself. But you seem to ask a
somewhat different question, for which I am not aware of.

Thanks.  -- Enke
