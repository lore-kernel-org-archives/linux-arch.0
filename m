From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 02/18] Documentation: document nospec helpers
Date: Fri, 05 Jan 2018 17:10:03 -0800
Message-ID: <151520100323.32271.8384226462583945132.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, peterz@infradead.org, netdev@vger.kernel.org, Will Deacon <will.deacon@arm.com>, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

Document the rationale and usage of the new nospec*() helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/speculation.txt |  166 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/speculation.txt

diff --git a/Documentation/speculation.txt b/Documentation/speculation.txt
new file mode 100644
index 000000000000..748fcd4dcda4
--- /dev/null
+++ b/Documentation/speculation.txt
@@ -0,0 +1,166 @@
+This document explains potential effects of speculation, and how undesirable
+effects can be mitigated portably using common APIs.
+
+===========
+Speculation
+===========
+
+To improve performance and minimize average latencies, many contemporary CPUs
+employ speculative execution techniques such as branch prediction, performing
+work which may be discarded at a later stage.
+
+Typically speculative execution cannot be observed from architectural state,
+such as the contents of registers. However, in some cases it is possible to
+observe its impact on microarchitectural state, such as the presence or
+absence of data in caches. Such state may form side-channels which can be
+observed to extract secret information.
+
+For example, in the presence of branch prediction, it is possible for bounds
+checks to be ignored by code which is speculatively executed. Consider the
+following code:
+
+	int load_array(int *array, unsigned int idx) {
+		if (idx >= MAX_ARRAY_ELEMS)
+			return 0;
+		else
+			return array[idx];
+	}
+
+Which, on arm64, may be compiled to an assembly sequence such as:
+
+	CMP	<idx>, #MAX_ARRAY_ELEMS
+	B.LT	less
+	MOV	<returnval>, #0
+	RET
+  less:
+	LDR	<returnval>, [<array>, <idx>]
+	RET
+
+It is possible that a CPU mis-predicts the conditional branch, and
+speculatively loads array[idx], even if idx >= MAX_ARRAY_ELEMS. This value
+will subsequently be discarded, but the speculated load may affect
+microarchitectural state which can be subsequently measured.
+
+More complex sequences involving multiple dependent memory accesses may result
+in sensitive information being leaked. Consider the following code, building on
+the prior example:
+
+	int load_dependent_arrays(int *arr1, int *arr2, int idx) {
+		int val1, val2,
+
+		val1 = load_array(arr1, idx);
+		val2 = load_array(arr2, val1);
+
+		return val2;
+	}
+
+Under speculation, the first call to load_array() may return the value of an
+out-of-bounds address, while the second call will influence microarchitectural
+state dependent on this value. This may provide an arbitrary read primitive.
+
+====================================
+Mitigating speculation side-channels
+====================================
+
+The kernel provides a generic API to ensure that bounds checks are respected
+even under speculation. Architectures which are affected by speculation-based
+side-channels are expected to implement these primitives.
+
+The following helpers found in <asm/barrier.h> can be used to prevent
+information from being leaked via side-channels.
+
+* nospec_ptr(ptr, lo, hi)
+
+  Returns a sanitized pointer that is bounded by the [lo, hi) interval. When
+  ptr < lo, or ptr >= hi, NULL is returned. Prevents an out-of-bounds pointer
+  being propagated to code which is speculatively executed.
+
+  This is expected to be used by code which computes pointers to data
+  structures, where part of the address (such as an array index) may be
+  user-controlled.
+
+  This can be used to protect the earlier load_array() example:
+
+  int load_array(int *array, unsigned int idx)
+  {
+	int *elem;
+
+	if ((elem = nospec_ptr(array + idx, array, array + MAX_ARRAY_ELEMS)))
+		return *elem;
+	else
+		return 0;
+  }
+
+  This can also be used in situations where multiple fields on a structure are
+  accessed:
+
+	struct foo array[SIZE];
+	int a, b;
+
+	void do_thing(int idx)
+	{
+		struct foo *elem;
+
+		if ((elem = nospec_ptr(array + idx, array, array + SIZE)) {
+			a = elem->field_a;
+			b = elem->field_b;
+		}
+	}
+
+  It is imperative that the returned pointer is used. Pointers which are
+  generated separately are subject to a number of potential CPU and compiler
+  optimizations, and may still be used speculatively. For example, this means
+  that the following sequence is unsafe:
+
+	struct foo array[SIZE];
+	int a, b;
+
+	void do_thing(int idx)
+	{
+		if (nospec_ptr(array + idx, array, array + SIZE) != NULL) {
+			// unsafe as wrong pointer is used
+			a = array[idx].field_a;
+			b = array[idx].field_b;
+		}
+	}
+
+  Similarly, it is unsafe to compare the returned pointer with other pointers,
+  as this may permit the compiler to substitute one pointer with another,
+  permitting speculation. For example, the following sequence is unsafe:
+
+	struct foo array[SIZE];
+	int a, b;
+
+	void do_thing(int idx)
+	{
+		struct foo *elem = nospec_ptr(array + idx, array, array + size);
+
+		// unsafe due to pointer substitution
+		if (elem == &array[idx]) {
+			a = elem->field_a;
+			b = elem->field_b;
+		}
+	}
+
+* nospec_array_ptr(arr, idx, sz)
+
+  Returns a sanitized pointer to arr[idx] only if idx falls in the [0, sz)
+  interval. When idx < 0 or idx > sz, NULL is returned. Prevents an
+  out-of-bounds pointer being propagated to code which is speculatively
+  executed.
+
+  This is a convenience function which wraps nospec_ptr(), and has the same
+  caveats w.r.t. the use of the returned pointer.
+
+  For example, this may be used as follows:
+
+  int load_array(int *array, unsigned int idx)
+  {
+	int *elem;
+
+	if ((elem = nospec_array_ptr(array, idx, MAX_ARRAY_ELEMS)))
+		return *elem;
+	else
+		return 0;
+  }
+
