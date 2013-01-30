From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v3 40/71] ARC: OProfile support
Date: Wed, 30 Jan 2013 17:16:17 +0530
Message-ID: <51090809.8010801@synopsys.com>
References: <1359025589-22277-1-git-send-email-vgupta@synopsys.com>
	<1359025589-22277-25-git-send-email-vgupta@synopsys.com>
	<5108016B.5050303@imgtec.com> <5108BEF5.6030500@synopsys.com>
	<5108FBFD.8080705@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
In-Reply-To: <5108FBFD.8080705@imgtec.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On Wednesday 30 January 2013 04:24 PM, James Hogan wrote:
> On 30/01/13 06:34, Vineet Gupta wrote:
>> On Tuesday 29 January 2013 10:35 PM, James Hogan wrote:
>>> Hi Vineet,
>>>
>>> You don't appear to define CONFIG_HW_PERF_EVENTS, so
>>> include/linux/oprofile.h will presumably define oprofile_perf_init as
>>> just a pr_info(...); return -ENODEV;
>>>
>>> Similarly drivers/oprofile/oprofile_perf.o doesn't seem to be being built.
>>>
>>> I'm probably missing something somewhere?
>> Not much :-)
>>
>> oprofile_arch_init() failure causes oprofile to fall back to timer based PC only
>> sampling - for coarse grained profiling. I'll soon be starting on integratign the
>> hardware counter support to both oprofile/perf.
> Okay cool. It's just slightly misleading for anybody copying the code
> that it calls oprofile_perf_init which is known never to do anything
> :-). Maybe it's worth adding a comment in there to clarify.

I think banner comment in oprofile.h for oprofile_arch_init() needs to document
that "in case it fails, oprofile switches to timer mode PC sampling".
But nevertheless it's good idea to add that clarification in my code anyways.

>  
> Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thx,
-Vineet

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
