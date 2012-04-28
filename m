From: Konstantin Khlebnikov <khlebnikov@openvz.org>
Subject: Re: [PATCH 1/4] compiler.h: introduce unused_expression() macro
Date: Sat, 28 Apr 2012 07:50:10 +0400
Message-ID: <4F9B68F2.2030205@openvz.org>
References: <20120425112623.26927.43229.stgit@zurg> <4F9A55EC.20804@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F9A55EC.20804@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

H. Peter Anvin wrote:
> On 04/25/2012 04:26 AM, Konstantin Khlebnikov wrote:
>> Sometimes we want to check some expressions correctness in compile-time without
>> generating extra code. "(void)(e)" does not work if expression has side-effects.
>> This patch introduces macro unused_expression() which helps in this situation.
>>
>> Cast to "long" required because sizeof does not work for bit-fields.
>>
>> Signed-off-by: Konstantin Khlebnikov<khlebnikov@openvz.org>
>> ---
>>   include/linux/compiler.h |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index 923d093..46fbda3 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -310,4 +310,6 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
>>    */
>>   #define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
>>
>> +#define unused_expression(e) ((void)(sizeof((__force long)(e))))
>> +
>
> OK, bikeshedding a bit:
>
> "unused_expression()" doesn't sound like something that inhibits side
> effects, especially since "unused" applied to an argument or variable
> means "don't make a fuss over this not being used."
>
> 	-hpa
>

Ok, in v2 I'll rename it into BUILD_BUG_ON_INVALID()
