$(document).ready(function() {

    $(".datetime").datetimepicker({
        format: 'Y-m-d',
        minDate: "-" + "<?php echo date('Y-m-d'); ?>",
        lang: 'es',
        timepicker: false,
        closeOnDateSelect: true
    });
    $('.timepicker').datetimepicker({
        datepicker: false,
        format: 'H:i',
        allowTimes: [
            '08:00', '08:30', '09:00', '09:30',
            '10:00', '10:30', '11:00', '11:30', '12:00',
            '12:30', '13:00', '13:30', '14:00',
            '14:30', '15:00', '15:30', '16:00', '16:30',
            '17:00', '17:30'
        ],
        step: 30,
        minTime: "08:00"
    });

});