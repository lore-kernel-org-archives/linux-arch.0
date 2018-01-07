From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFCv2 2/4] Documentation: document nospec helpers
Date: Sun, 7 Jan 2018 11:27:46 +0100
Message-ID: <CAMuHMdWavQqL4GXCoYboWsD4_hy_uiU4vr=ragRcc-odxYGaYw@mail.gmail.com>
References: <20180105145750.53294-1-mark.rutland@arm.com> <20180105145750.53294-3-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34821 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbeAGK1r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jan 2018 05:27:47 -0500
In-Reply-To: <20180105145750.53294-3-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, elena.reshetova@intel.com, Jonathan Corbet <corbet@lwn.net>, Alan Cox <alan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>

Hi Mark,

On Fri, Jan 5, 2018 at 3:57 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Document the rationale and usage of the new nospec*() helpers.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Peter Zijlstra <peterz@infradead.org>

I love your patch! Yet something to improve:
(borrowed from another Intel division)

> --- /dev/null
> +++ b/Documentation/speculation.txt
> @@ -0,0 +1,166 @@
> +This document explains potential effects of speculation, and how undesirable
> +effects can be mitigated portably using common APIs.
> +
> +===========
> +Speculation
> +===========
> +
> +To improve performance and minimize average latencies, many contemporary CPUs
> +employ speculative execution techniques such as branch prediction, performing
> +work which may be discarded at a later stage.
> +
> +Typically speculative execution cannot be observed from architectural state,
> +such as the contents of registers. However, in some cases it is possible to
> +observe its impact on microarchitectural state, such as the presence or
> +absence of data in caches. Such state may form side-channels which can be
> +observed to extract secret information.
> +
> +For example, in the presence of branch prediction, it is possible for bounds
> +checks to be ignored by code which is speculatively executed. Consider the
> +following code:
> +
> +       int load_array(int *array, unsigned int idx) {

"{" on next line?

> +               if (idx >= MAX_ARRAY_ELEMS)
> +                       return 0;
> +               else
> +                       return array[idx];
> +       }
> +
> +Which, on arm64, may be compiled to an assembly sequence such as:
> +
> +       CMP     <idx>, #MAX_ARRAY_ELEMS
> +       B.LT    less
> +       MOV     <returnval>, #0
> +       RET
> +  less:
> +       LDR     <returnval>, [<array>, <idx>]
> +       RET
> +
> +It is possible that a CPU mis-predicts the conditional branch, and
> +speculatively loads array[idx], even if idx >= MAX_ARRAY_ELEMS. This value
> +will subsequently be discarded, but the speculated load may affect
> +microarchitectural state which can be subsequently measured.
> +
> +More complex sequences involving multiple dependent memory accesses may result
> +in sensitive information being leaked. Consider the following code, building on
> +the prior example:
> +
> +       int load_dependent_arrays(int *arr1, int *arr2, int idx) {

"{" on next line

> +               int val1, val2,
> +
> +               val1 = load_array(arr1, idx);
> +               val2 = load_array(arr2, val1);
> +
> +               return val2;
> +       }
> +
> +Under speculation, the first call to load_array() may return the value of an
> +out-of-bounds address, while the second call will influence microarchitectural
> +state dependent on this value. This may provide an arbitrary read primitive.
> +
> +====================================
> +Mitigating speculation side-channels
> +====================================
> +
> +The kernel provides a generic API to ensure that bounds checks are respected
> +even under speculation. Architectures which are affected by speculation-based
> +side-channels are expected to implement these primitives.
> +
> +The following helpers found in <asm/barrier.h> can be used to prevent
> +information from being leaked via side-channels.
> +
> +* nospec_ptr(ptr, lo, hi)
> +
> +  Returns a sanitized pointer that is bounded by the [lo, hi) interval. When
> +  ptr < lo, or ptr >= hi, NULL is returned. Prevents an out-of-bounds pointer
> +  being propagated to code which is speculatively executed.
> +
> +  This is expected to be used by code which computes pointers to data
> +  structures, where part of the address (such as an array index) may be
> +  user-controlled.
> +
> +  This can be used to protect the earlier load_array() example:
> +
> +  int load_array(int *array, unsigned int idx)
> +  {
> +       int *elem;
> +
> +       if ((elem = nospec_ptr(array + idx, array, array + MAX_ARRAY_ELEMS)))

elem = nospec_ptr(array + idx, array, array + MAX_ARRAY_ELEMS);
if (elem)

> +               return *elem;
> +       else
> +               return 0;
> +  }
> +
> +  This can also be used in situations where multiple fields on a structure are
> +  accessed:
> +
> +       struct foo array[SIZE];
> +       int a, b;
> +
> +       void do_thing(int idx)
> +       {
> +               struct foo *elem;
> +
> +               if ((elem = nospec_ptr(array + idx, array, array + SIZE)) {

elem = nospec_ptr(array + idx, array, array + SIZE;
if (elem) {

> +                       a = elem->field_a;
> +                       b = elem->field_b;
> +               }
> +       }
> +
> +  It is imperative that the returned pointer is used. Pointers which are
> +  generated separately are subject to a number of potential CPU and compiler
> +  optimizations, and may still be used speculatively. For example, this means
> +  that the following sequence is unsafe:
> +
> +       struct foo array[SIZE];
> +       int a, b;
> +
> +       void do_thing(int idx)
> +       {
> +               if (nospec_ptr(array + idx, array, array + SIZE) != NULL) {
> +                       // unsafe as wrong pointer is used
> +                       a = array[idx].field_a;
> +                       b = array[idx].field_b;
> +               }
> +       }
> +
> +  Similarly, it is unsafe to compare the returned pointer with other pointers,
> +  as this may permit the compiler to substitute one pointer with another,
> +  permitting speculation. For example, the following sequence is unsafe:
> +
> +       struct foo array[SIZE];
> +       int a, b;
> +
> +       void do_thing(int idx)
> +       {
> +               struct foo *elem = nospec_ptr(array + idx, array, array + size);
> +
> +               // unsafe due to pointer substitution
> +               if (elem == &array[idx]) {
> +                       a = elem->field_a;
> +                       b = elem->field_b;
> +               }
> +       }
> +
> +* nospec_array_ptr(arr, idx, sz)
> +
> +  Returns a sanitized pointer to arr[idx] only if idx falls in the [0, sz)
> +  interval. When idx < 0 or idx > sz, NULL is returned. Prevents an
> +  out-of-bounds pointer being propagated to code which is speculatively
> +  executed.
> +
> +  This is a convenience function which wraps nospec_ptr(), and has the same
> +  caveats w.r.t. the use of the returned pointer.
> +
> +  For example, this may be used as follows:
> +
> +  int load_array(int *array, unsigned int idx)
> +  {
> +       int *elem;
> +
> +       if ((elem = nospec_array_ptr(array, idx, MAX_ARRAY_ELEMS)))

elem = nospec_array_ptr(array, idx, MAX_ARRAY_ELEMS);
if (elem)

> +               return *elem;
> +       else
> +               return 0;
> +  }
> +

Gr{oetje,eeting}s,

                        Geert
