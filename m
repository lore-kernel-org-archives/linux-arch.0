From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 04/40] trace/ring_buffer: handle 64bit aligned
 structs
Date: Wed, 31 Oct 2012 18:19:50 +0000
Message-ID: <50916BC6.8080906@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>  <1351700061-7203-5-git-send-email-james.hogan@imgtec.com> <1351706364.4004.87.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:51801 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933682Ab2JaSUD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 14:20:03 -0400
In-Reply-To: <1351706364.4004.87.camel@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-arch@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>

On 31/10/12 17:59, Steven Rostedt wrote:
> On Wed, 2012-10-31 at 16:13 +0000, James Hogan wrote:
>> Some 32 bit architectures have 64 bit struct alignment (for example
>> metag which has 64 bit read/write instructions). These require 8 byte
>> alignment of event data too, so use CONFIG_HAVE_64BIT_ALIGNED_STRUCT
>> instead of CONFIG_64BIT to decide alignment, and align
>> buffer_data_page::data accordingly.
> 
> Can you test if trace-cmd still reads this correctly.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/trace-cmd.git
> 
> Run a simple:
> 
>  trace-cmd record -e all sleep 2
>  trace-cmd report
> 
> and make sure that the events report correctly your arch (metag). I just
> want to make sure that it still reads the binary data correctly. I
> should as the /sys/kernel/debug/tracing/events/header_page should
> express the difference in the offset of data.

Hi Steven,

Will do, thanks for the suggestion.

> 
> Also, I wish you Cc'd LKML, as there's some changes I would have liked
> to look at, but I'm not subscribed to the linux-arch mailing list.

Sorry. I'll cc LKML for V2.

Thanks
James

> 
> -- Steve
> 
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Frederic Weisbecker <fweisbec@gmail.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> ---
>>  kernel/trace/ring_buffer.c |    7 +++++--
>>  1 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>> index 49491fa..15a63d8 100644
>> --- a/kernel/trace/ring_buffer.c
>> +++ b/kernel/trace/ring_buffer.c
>> @@ -177,7 +177,8 @@ void tracing_off_permanent(void)
>>  #define RB_MAX_SMALL_DATA	(RB_ALIGNMENT * RINGBUF_TYPE_DATA_TYPE_LEN_MAX)
>>  #define RB_EVNT_MIN_SIZE	8U	/* two 32bit words */
>>  
>> -#if !defined(CONFIG_64BIT) || defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
>> +#if !defined(CONFIG_HAVE_64BIT_ALIGNED_STRUCT) || \
>> +	defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
>>  # define RB_FORCE_8BYTE_ALIGNMENT	0
>>  # define RB_ARCH_ALIGNMENT		RB_ALIGNMENT
>>  #else
>> @@ -185,6 +186,8 @@ void tracing_off_permanent(void)
>>  # define RB_ARCH_ALIGNMENT		8U
>>  #endif
>>  
>> +#define RB_ALIGN_DATA		__aligned(RB_ARCH_ALIGNMENT)
>> +
>>  /* define RINGBUF_TYPE_DATA for 'case RINGBUF_TYPE_DATA:' */
>>  #define RINGBUF_TYPE_DATA 0 ... RINGBUF_TYPE_DATA_TYPE_LEN_MAX
>>  
>> @@ -333,7 +336,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
>>  struct buffer_data_page {
>>  	u64		 time_stamp;	/* page time stamp */
>>  	local_t		 commit;	/* write committed index */
>> -	unsigned char	 data[];	/* data of buffer page */
>> +	unsigned char	 data[] RB_ALIGN_DATA;	/* data of buffer page */
>>  };
>>  
>>  /*
> 
> 
