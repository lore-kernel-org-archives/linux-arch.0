From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 10/12] tracing: Update sample file to describe the new
 macro
Date: Tue, 13 Jun 2017 17:07:55 -0400
Message-ID: <20170613170755.13331121@gandalf.local.home>
References: <20170531215653.3240-1-jeremy.linton@arm.com>
        <20170531215653.3240-11-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531215653.3240-11-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org
List-Id: linux-arch.vger.kernel.org

On Wed, 31 May 2017 16:56:51 -0500
Jeremy Linton <jeremy.linton@arm.com> wrote:

> Add a blurb in the trace sample file to describe
> the macro used to add sizeof to value conversions.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  samples/trace_events/trace-events-sample.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
> index 76a75ab..82e1e66 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -225,6 +225,13 @@ TRACE_DEFINE_ENUM(TRACE_SAMPLE_FOO);
>  TRACE_DEFINE_ENUM(TRACE_SAMPLE_BAR);
>  TRACE_DEFINE_ENUM(TRACE_SAMPLE_ZOO);
>  
> +/*
> + * The same problem as above applies to sizeof(), so there is also
> + * a macro to solve that problem.
> + */
> +
> +TRACE_DEFINE_SIZEOF(pteval_t);
> +

Could you add this in the example too. That is, a use case. Just
having the define isn't a proper sample. You want to use it in a
TP_printk() too.

-- Steve

>  TRACE_EVENT(foo_bar,
>  
>  	TP_PROTO(const char *foo, int bar, const int *lst,
