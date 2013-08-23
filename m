From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/4] gcov: move gcov structs definitions to a gcc
 version specific file
Date: Fri, 23 Aug 2013 17:09:58 +0200
Message-ID: <52177B46.6070404@linux.vnet.ibm.com>
References: <1377247176-13537-1-git-send-email-fhrbata@redhat.com> <1377247176-13537-2-git-send-email-fhrbata@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377247176-13537-2-git-send-email-fhrbata@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frantisek Hrbata <fhrbata@redhat.com>
Cc: linux-kernel@vger.kernel.org, jstancek@redhat.com, keescook@chromium.org, peter.oberparleiter@de.ibm.com, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, arnd@arndb.de, mgahagan@redhat.com, agospoda@redhat.com
List-Id: linux-arch.vger.kernel.org

On 23.08.2013 10:39, Frantisek Hrbata wrote:
> Since also the gcov structures(gcov_info, gcov_fn_info, gcov_ctr_info) can
> change between gcc releases, as shown in gcc 4.7, they cannot be defined in a
> common header and need to be moved to a specific gcc implemention file. This
> also requires to make the gcov_info structure opaque for the common code and to
> introduce simple helpers for accessing data inside gcov_info.

I've taken a similar approach in my version, although I stopped at isolating
the code that handles the linked list. I like your version better since it's
more consistent.

> diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
> index ae5bb42..27bc88a 100644
> --- a/kernel/gcov/gcc_3_4.c
> +++ b/kernel/gcov/gcc_3_4.c
> @@ -21,6 +21,121 @@
>  #include <linux/vmalloc.h>
>  #include "gcov.h"
> 
> +#define GCOV_COUNTERS		5

The value for GCOV_COUNTERS has been changed with GCC 4.3. Before it was 5,
starting with GCC 4.3 the value is 8. While this is not strictly necessary, I'm
wondering if this should be added here to prevent any unwanted side-effects.

-- 
Peter Oberparleiter
Linux on System z Development - IBM Germany
